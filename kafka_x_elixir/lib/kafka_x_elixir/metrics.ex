defmodule KafkaXElixir.Metrics do
  import Telemetry.Metrics

  def metrics do
    [
      summary("broadway.processor.stop.duration",
        unit: {:native, :millisecond}
      ),
      counter("broadway.processor.message.stop.count"),
      summary("broadway.batch_processor.stop.duration",
        unit: {:native, :millisecond}
      )
      # ajoutez d'autres métriques si besoin
    ]
  end
end
