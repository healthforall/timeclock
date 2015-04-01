module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I am on my (.+)$/ do |page_name|
  #
  # step definition in clockinclockout_steps.rb
  #
  def path_to(page_name, employee)
    case page_name

      when /^home\s?page$/
        '/'
      when /^(.+)$/
        path_components = $1.split(/\s+/).reverse
        if path_components.length >= 2
          "/employees/#{employee.id}/#{path_components[0]}s/1/#{path_components[1]}"
        end
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
    end
  end
end

World(NavigationHelpers)