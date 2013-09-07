module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create posts" => "Create Posts",
      "edit posts" => "Edit Posts",
      "delete posts" => "Delete Posts"
    }
  end
end
