We are running Ruby 1.9 and Rails 3 with permission.

cucumber.txt contains both normal Cucumber tests AND Selenium tests.

rcov does not seem to be compatable with Ruby 1.9 and Rails 3.0. Running `rcov` doesn't seem to work, and
running `rake spec:rcov` seems to only output HTML.


INCLUDED DUMMY DATA:

TRIP
Name: Visit to Apple
Time: December 23, 2010 - 12:30 PM
Address: 1 Infinite Loop, Cupertino, CA 95014, USA
TRIP ORGANIZER: person1

PARTICIPANTS
== Organizer ==
Email: person1@email.com
Password: person1@email.com
Name: First1 Last1
Phone: 1234567891
Address: 1930 Hearst Ave, Berkeley, CA 94709, USA

== Driver ==
Email: person2@email.com
Password: person2@email.com
Name: First2 Last2
Phone: 1234567892
Address: 1926 Virginia St, Berkeley, CA 94709, USA

Email: person3@email.com
Password: person3@email.com
Name: First3 Last3
Phone: 1234567893
Address: 1800 Rose St, Berkeley, CA 94703, USA

Email: person4@email.com
Password: person4@email.com
Name: First4 Last4
Phone: 1234567894
Address: 1700 Beverly Place, Berkeley, CA


TRYING RIDE GENERATION FEATURES
Have one person (the trip organizer) create an account and then a trip.
Have another person (the driver) create an account and add a vehicle.
Have the trip organizer invite the driver.
Have the driver accept the invitation.
Have the trip organizer generate arrangements.