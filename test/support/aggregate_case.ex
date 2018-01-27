defmodule Surveys.AggregateCase do
  use ExUnit.CaseTemplate

  using aggregate: aggregate do
    quote bind_quoted: [aggregate: aggregate] do
      @aggregate_module aggregate
      import Surveys.Factory

      defp assert_events(commands, expected_events) do
        assert_events(%@aggregate_module{}, commands, expected_events)
      end

      defp assert_events(aggregate, commands, expected_events) do
        {_agg, events, error} = execute(commands, aggregate)

        assert is_nil(error)
        assert List.wrap(events) == expected_events
      end

      defp execute(commands, aggregate \\ %@aggregate_module{})

      defp execute(commands, aggregate) do
        commands
        |> List.wrap()
        |> Enum.reduce({aggregate, [], nil}, fn
          command, {aggregate, _events, nil} ->
            case @aggregate_module.execute(aggregate, command) do
              {:error, reason} = error -> {aggregate, nil, error}
              events -> {evolve(aggregate, events), events, nil}
            end

          command, {aggregate, _events, _error} = reply ->
            reply
        end)
      end

      # apply the given events to the aggregate state
      defp evolve(aggregate, events) do
        events
        |> List.wrap()
        |> Enum.reduce(aggregate, &@aggregate_module.apply(&2, &1))
      end
    end
  end
end
