require "test_helper"

class AssignCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(
      username: "janet",
      email: "janet@jems.ca",
      password: "Password",
      admin: true
    )
    @article = Article.create(
      title: "Article",
      description: "This is an article",
      user_id: @user.id
    )
    @category = Category.create(name: "sports")
    @category2 = Category.create(name: "programming")
  end
  
  test "should show categories listing" do
    get categories_path
    assert_template "categories/index"
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

end
