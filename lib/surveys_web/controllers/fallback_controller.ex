defmodule SurveysWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use SurveysWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(SurveysWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :validation_failure, errors}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(SurveysWeb.ValidationView, "error.json", errors: errors)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(SurveysWeb.ErrorView, :"404")
  end

  def call(conn, {:error, error}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(SurveysWeb.ErrorView, error)
  end
end
