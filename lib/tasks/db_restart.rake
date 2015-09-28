namespace :db do

	desc "Drops, migrates and seeds database"
	task :restart => [:drop, :migrate, :seed, :populate_for]
end
