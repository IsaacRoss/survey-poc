defmodule Surveys.AggregateCase do
  use ExUnit.CaseTemplate

  using aggregate: aggregate do
    quote bind_quoted: [aggregate: aggregate] do
      @aggregate_module aggregate
      import Surveys.Factory

      defp assert_event(command, expected_event) do
        event = @aggregate_module.execute(%@aggregate_module{}, command)
        assert expected_event == event
      end
    end
  end
end
