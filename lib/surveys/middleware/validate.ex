defmodule Surveys.Middleware.Validate do
  @behavior Commanded.Middleware

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
    |> Enum.group_by(fn {_error, field, _validtype, _message} -> field end, fn {_error, _field,
                                                                                _validtype,
                                                                                message} ->
      message
    end)
    |> Map.new()
  end
end
