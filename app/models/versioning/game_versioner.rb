class GameVersioner < Versioner

	@@instance = GameVersioner.new

	def self.instance
		@@instance
	end

	def new_video_hash(oldVersion)
		newest = current_version oldVersion
		hash = Hash.new
		ovs = Array.new(oldVersion.videos)
		nvs = Array.new(newest.videos)
		ovs.each do |ov|
			nvs.each do |nv|
				if nv.embedcode == ov.embedcode
					hash[ov.id] = nv.id
					nvs.delete nv
					break
				end
			end
		end
		return hash
	end

	# returns the mixed fields with the current version
	def current_version_mixed_fields(mfs)
		return if mfs == nil
		g_hash = Hash.new
		ret_array = Array.new
		mfs.each do |mf|
			g = g_hash[mf.game.version_id]
			if g == nil
				g = current_version mf.game
				g_hash[mf.game.version_id] = g
			end
			if mf.game_id == g.id
				ret_array.push mf
			end
		end
		ret_array
	end

	protected
	# needs to be overridden in subclass
	# returns the active record model class object
	def model_class
		Game
	end

	# adds additional behaviour to the revert_to_this method before saving the record
	# override in subclass if wanted
	def revert_additional_behaviour_before_save(revert_to, current_newest, newVersion)
		# change attributes from most recent version
		newVersion.popularity = current_newest.popularity
	end

	# adds additional behaviour to the revert_to_this method after saving the record
	# override in subclass if wanted
	def revert_additional_behaviour_after_save(revert_to, current_newest, newVersion)
		# change report/block/delete
		change_rbc current_newest, newVersion, 0
	end

	#adds additional behaviour to the new_version method
	# override in sublass if wanted
	def new_version_additional_behaviour_before_save(oldVersion, newVersion, params)
		newVersion.title = oldVersion.title
		newVersion.description = oldVersion.description
		newVersion.created_at = oldVersion.created_at
		newVersion.updated_at = Time.now

		newVersion.image = oldVersion.image.file
		newVersion.popularity = oldVersion.popularity

		# fields
		oldVersion.fields.each do |f|
			newVersion.fields.push f.copy_without_references
		end

		# release dates
		oldVersion.release_dates.each do |rd|
			newVersion.release_dates.push rd.copy_without_references
		end

		# videos
		oldVersion.videos.each do |v|
			newVersion.videos.push v.copy_without_references
		end

		screenshot_versioning oldVersion, newVersion, params

		# genres
		oldVersion.genres.each do |g|
			newVersion.genres.push g
		end

		# platforms
		oldVersion.platforms.each do |p|
			newVersion.platforms.push p
		end

		# media
		oldVersion.media.each do |m|
			newVersion.media.push m
		end

		# modes
		oldVersion.modes.each do |m|
			newVersion.modes.push m
		end

		# tags
		oldVersion.tags.each do |t|
			newVersion.tags.push t
		end

	end

	# adds additional behaviour to the new_version method after saving the record
	# override in sublass if wanted
	def new_version_additional_behaviour_after_save(oldVersion, newVersion, params)
		# change report/block/delete
		change_rbc oldVersion, newVersion, 0
		copy_mixed_fields oldVersion, newVersion
		mixed_fields_update_series_references oldVersion, newVersion
	end

	def copy_mixed_fields(oldVersion, newVersion)
		# mixed fields
		oldVersion.mixed_fields.each do |mf|
			nmf = mf.dup
			nmf.game_id = newVersion.id
			nmf.save
		end
	end

	def mixed_fields_update_series_references(oldVersion, newVersion)
		smf = MixedField.where(:series_game_id => oldVersion.id)
		return if smf == nil

		smf.each do |smfe|
			smfe.series_game_id = newVersion.id
			smfe.save
		end
	end

	private
	def screenshot_versioning(oldVersion, newVersion, params)
		# screenshots
		puts 'version screenshots'
		if params != nil
			sp = params[:game][:screenshots_attributes]
			new_sp = HashWithIndifferentAccess.new
			puts sp
			if sp != nil
				count = 0
				sp.each do |k, v|
					id = v[:id]
					image = v[:image]
					destroyImage = v[:_destroy]
					if destroyImage == "1"
						# puts "screenshot #{k} with id #{id} deleted"
						next
					elsif image == nil
						# old image
						# puts "screenshot #{k} with id #{id} is old -> copy to new version"
						old_ss = Screenshot.find(id.to_i)
						newVersion.screenshots.push old_ss.copy_without_references unless old_ss == nil
					else
						# new screenshot -> leave in params
						# puts "screenshot #{k} with id #{id} is new -> leave in params on position #{count}"
						new_sp[count.to_s] = sp[k]
						count += 1
					end
				end
				params[:game][:screenshots_attributes] = new_sp
			end
			# puts sp
			# puts 'version screenshots end'
		else
			# params nil -> just copy old screenshots
			# puts "just copy old screenshots"
			oldVersion.screenshots.each do |os|
				newVersion.screenshots.push os.copy_without_references
			end
		end
	end
end