module ApplicationHelper


  def options_for_organization_types
    Organization::OrganizationTypesFriendlyNames.invert.to_a
  end

  def options_for_user_roles
    User::RolesFriendlyName.invert.to_a
  end

  def options_for_search_types selected_item=nil
    options_for_select([["All",""],["Applications",Organization::AppKeyWord],["Techs",Organization::TechKeyWord],["Problems",Organization::ProblemKeyWord]],selected_item)
  end

  def get_tags_hash_for_autocomplete
    tags_hash={}
    tags_hash[:all]=ActsAsTaggableOn::Tag.select(:name).map &:name
    tags_hash[Organization::TechKeyWord]= ActsAsTaggableOn::Tag.joins(:taggings).where({taggings: {context: 'technology_areas'}}).uniq.map &:name
    tags_hash[Organization::AppKeyWord]= ActsAsTaggableOn::Tag.joins(:taggings).where({taggings: {context: 'application_areas'}}).uniq.map &:name
    tags_hash[Organization::ProblemKeyWord]= ActsAsTaggableOn::Tag.joins(:taggings).where({taggings: {context: 'problems'}}).uniq.map &:name
    tags_hash
  end
end
