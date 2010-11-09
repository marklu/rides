module Authentication
  def signin(user)
    sign_in(user)
    controller.stub(:current_person).and_return(user)
  end

  def signout(user)
    sign_out(user)
  end
end