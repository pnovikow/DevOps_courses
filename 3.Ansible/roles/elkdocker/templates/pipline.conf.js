input {
    udp {
        port => 5000
        codec => "json"
        type => "rsyslog"
    }
}
filter {
    json {
        source => "message"
        skip_on_invalid_json => true
    }
}
output {
    elasticsearch {
        index => "rsyslog-%{+YYYY.MM}"
        hosts => "elasticsearch:9200"
        user => "elastic"
        password => "masteradmin"
    }
}