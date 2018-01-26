defmodule Surveys.AggregateCase do
  use ExUnit.CaseTemplate

  using aggregate: aggregate do
    quote bind_quoted: [aggregate: aggregate] do
      @aggregate_module aggregate
      import Surveys.Factory

      defp assert_event(command, expected_event) do
        # _agg, unused for now, is the aggregate after event has been applied to
        # it, This will probably be useful for testing more complex aggregates
        # in the future.
        {_agg, event, error} = execute(command)

        # assert there are no errors
        assert is_nil(error)

        # assert expected event matches up
        assert expected_event == event
      end

      defp execute(command) do
        case @aggregate_module.execute(%@aggregate_module{}, command) do
          {:error, reason} = error -> {%@aggregate_module{}, nil, error}
          event -> {apply(event), event, nil}
        end
      end

      defp apply(event) do
        @aggregate_module.apply(%@aggregate_module{}, event)
      end
    end
  end
end
