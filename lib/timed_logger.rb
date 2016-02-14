class TimedLogger
  attr_reader :log, :name, :start_time, :stop_time

  def initialize(name)
    @log        = ActiveSupport::Logger.new("log/#{name}.log")
    @name       = name
    @start_time = Time.now
    @stop_time  = nil
  end

  def error(message)
    log.error message
    puts message.red
  end

  def info(message)
    log.info message
    puts message.green
  end

  def start
    info "#{name} started at #{start_time}"
  end

  def stop
    @stop_time = Time.now
    duration = (start_time - stop_time) / 1.minute
    info "#{name} completed at #{stop_time} and ran for #{duration} minutes."
    log.close
  end

end