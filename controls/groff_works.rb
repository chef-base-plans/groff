base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "groff")
plan_ident = "#{plan_origin}/#{plan_name}"

hab_pkg_path = command("hab pkg path #{plan_ident}")
describe hab_pkg_path do
  its('exit_status') { should eq 0 }
  its('stdout') { should_not be_empty }
end

target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

describe command("#{File.join(target_dir, plan_name)} -v") do
  its('stdout') { should match /GNU groff version [0-9]+.[0-9]+.[0-9]+/  }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
