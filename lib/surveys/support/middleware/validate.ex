defmodule Surveys.Support.Middleware.Validate do
  @behaviour Commanded.Middleware

  alias Commanded.Middleware.Pipeline
  import Pipeline

  def before_dispatch(%Pipeline{command: command} = pipeline) do
    case Vex.valid?(command) do
      true -> pipeline
      false -> failed_validation(pipeline)
    end
  end

  def after_dispatch(pipeline), do: pipeline
  def after_failure(pipeline), do: pipeline

  def failed_validation(%Pipeline{command: command} = pipeline) do
    errors = command |> Vex.errors() |> merge_errors

    pipeline
    |> respond({:error, :validation_failure, errors})
    |> halt()
  end

  defp merge_errors(errors) do
    errors
    |> Enum.group_by(&get_field/1, &get_message/1)
    |> Map.new()
  end

  defp get_field({_error, field, _validtype, _message}) do
    field
  end

  defp get_message({_error, _field, _validtype, message}) do
    message
  end
end
