module ApplicationHelper

  def options_for_organization_types
    Organization::OrganizationTypesFriendlyNames.invert.to_a
  end

  def options_for_user_roles
    User::RolesFriendlyName.invert.to_a
  end
end
