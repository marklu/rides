We are running Ruby 1.9 and Rails 3 with permission.

cucumber.txt contains both normal Cucumber tests AND Selenium tests.

rcov does not seem to be compatable with Ruby 1.9 and Rails 3.0. Running `rcov` doesn't seem to work, and
running `rake spec:rcov` seems to only output HTML.