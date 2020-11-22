require 'test_helper'

class CommentairesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commentaire = commentaires(:one)
  end

  test "should get index" do
    get commentaires_url, as: :json
    assert_response :success
  end

  test "should create commentaire" do
    assert_difference('Commentaire.count') do
      post commentaires_url, params: { commentaire: { comments: @commentaire.comments } }, as: :json
    end

    assert_response 201
  end

  test "should show commentaire" do
    get commentaire_url(@commentaire), as: :json
    assert_response :success
  end

  test "should update commentaire" do
    patch commentaire_url(@commentaire), params: { commentaire: { comments: @commentaire.comments } }, as: :json
    assert_response 200
  end

  test "should destroy commentaire" do
    assert_difference('Commentaire.count', -1) do
      delete commentaire_url(@commentaire), as: :json
    end

    assert_response 204
  end
end
