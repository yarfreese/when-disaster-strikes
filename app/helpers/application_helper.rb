module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "WDS").join(" - ")
      end
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end
end
