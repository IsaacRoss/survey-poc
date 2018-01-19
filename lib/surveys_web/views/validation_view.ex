defmodule SurveysWeb.ValidationView do
  use SurveysWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end
