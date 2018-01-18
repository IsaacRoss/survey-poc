defmodule Surveys.Factory do
  use ExMachina

  def survey_factory do
    %{
      title: "My Awesome Survey",
      questions: [%{title: "whatever"}]
    }
  end
end
