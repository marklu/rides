We are running Ruby 1.9 and Rails 3 with permission.

Due to ethical concerns, we have made a middle-of-iteration decision to disable all Google Maps features.
All relevant code and tests have thus been commented out.

rcov does not seem to be compatable with Ruby 1.9 and Rails 3.0. Running `rcov` doesn't seem to work, and
running `rake spec:rcov` seems to only output HTML.