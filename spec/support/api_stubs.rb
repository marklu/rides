module APIStubs
  def stub_geocoder
    Geocoder.stub(:search).and_return({
      'status' => 'OK',
      'results' => [
        {
          'types' => ['street_address'],
          'formatted_address' => '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA',
          'address_components' => [
            {'long_name' => '1600', 'short_name' => '1600', 'types' => ['street_number']},
            {'long_name' => 'Amphitheatre Pkwy', 'short_name' => 'Amphitheatre Pkwy', 'types' => ['route']},
            {'long_name' => 'Mountain View', 'short_name' => 'Mountain View', 'types' => ['locality', 'political']},
            {'long_name' => 'San Jose', 'short_name' => 'San Jose', 'types' => ['administrative_area_level_3', 'political']},
            {'long_name' => 'Santa Clara', 'short_name' => 'Santa Clara', 'types' => ['administrative_area_level_2', 'political']},
            {'long_name' => 'California', 'short_name' => 'CA', 'types' => ['administrative_area_level_1', 'political']},
            {'long_name' => 'United States', 'short_name' => 'US', 'types' => ['country', 'political']},
            {'long_name' => '94043', 'short_name' => '94043', 'types' => ['postal_code']}
          ],
          'geometry' => {
            'location' => {'lat' => 37.422782, 'lng' => -122.085099},
            'location_type' => 'ROOFTOP',
            'viewport' => {
              'southwest' => {'lat' => 37.4196344, 'lng' => -122.0882466},
              'northeast' => {'lat' => 37.4259296, 'lng' => -122.0819514}
            }
          }
        }
      ]
  })
  end

  def unstub_geocoder
    Geocoder.unstub(:search)
  end
end