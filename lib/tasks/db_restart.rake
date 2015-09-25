namespace :db do

	desc "Drops, migrate and seed database"
	task :restart => [:drop, :migrate, :seed, :populate_for]
end
