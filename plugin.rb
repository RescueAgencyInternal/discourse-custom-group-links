# name: discourse-custom-group-links
# about: Adds social media links to Discourse Groups
# version: 0.2
# authors: Rescue Agency
# url: https://github.com/RescueAgencyInternal/discourse-custom-group-links

after_initialize do
  # Allow these custom fields to be edited via the admin UI:
  register_editable_group_custom_field("facebook_url")
  register_editable_group_custom_field("linkedin_url")
  register_editable_group_custom_field("twitter_url")
  register_editable_group_custom_field("instagram_url")
  register_editable_group_custom_field("youtube_url")
  register_editable_group_custom_field("website_url")
  register_editable_group_custom_field("contact_email")
  register_editable_group_custom_field("topic")
  register_editable_group_custom_field("is_partner_group")

  # Define the data type for each custom field (use :text for URLs and email):
  register_group_custom_field_type("facebook_url", :text)
  register_group_custom_field_type("linkedin_url", :text)
  register_group_custom_field_type("twitter_url", :text)
  register_group_custom_field_type("instagram_url", :text)
  register_group_custom_field_type("youtube_url", :text)
  register_group_custom_field_type("website_url", :text)
  register_group_custom_field_type("contact_email", :text)
  register_group_custom_field_type("topic", :text)
  register_group_custom_field_type("is_partner_group", :boolean)


  # Ensure these fields are preloaded (avoids N+1 queries if listing groups):
  if Group.respond_to?(:preloaded_custom_fields)
    Group.preloaded_custom_fields << "facebook_url"
    Group.preloaded_custom_fields << "linkedin_url"
    Group.preloaded_custom_fields << "twitter_url"
    Group.preloaded_custom_fields << "instagram_url"
    Group.preloaded_custom_fields << "youtube_url"
    Group.preloaded_custom_fields << "website_url"
    Group.preloaded_custom_fields << "contact_email"
    Group.preloaded_custom_fields << "topic"
    Group.preloaded_custom_fields << "is_partner_group"
  end

  # Include custom_fields in the group JSON responses so they are visible to clients:
  add_to_serializer(:basic_group, :custom_fields) { object.custom_fields }

  Group.after_create do |group|
    group.custom_fields["is_partner_group"] = true
    group.save_custom_fields
  end
end
