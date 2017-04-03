module UsersHelper
  def ad_user_label(user)
    label = "<label class='label label-success tool-tip' title='Autenticação pelo Active Directory e Local'>Híbrida</label>"
    if user.ad_user?
      label = "<label class='label label-primary tool-tip' title='Autenticação apenas pelo Active Directory'>Apenas AD</label>"
    end
    label.html_safe
  end
end
