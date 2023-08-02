require 'google/apis/civicinfo_v2'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new

civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

p response = civic_info.representative_info_by_address(address: 80_202, levels: 'country',
                                                     roles: %w[legislatorUpperBody legislatorLowerBody])

# p response.officials
