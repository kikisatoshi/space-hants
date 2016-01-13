module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    if user.present? && user.avatar?
      image_tag(user.avatar.url, alt: user.name, class: "gravatar")
    else
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/?s=#{size}&d=mm"
      image_tag(gravatar_url, class: "gravatar")
    end
  end
end
