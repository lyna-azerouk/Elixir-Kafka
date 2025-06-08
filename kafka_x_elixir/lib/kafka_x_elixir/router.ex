# defmodule KafkaXElixir.Router do
#   use Plug.Router

#   plug Plug.Logger
#   plug :match
#   plug :dispatch

#   forward "/metrics", to: TelemetryMetricsPrometheus.Plug

#   match _ do
#     send_resp(conn, 404, "Not found")
#   end
# end
