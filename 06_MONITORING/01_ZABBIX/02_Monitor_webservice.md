## Monitor external application
Add a new web_scenario and monitor the avability of the service under the address:

https://sparkling-leaf-9884.getsandbox.com:443/MONITOR


* Add a monitoring item **HTTP agent**
* Make it return **200** (modify the header - Content-Type)
* Add a slack trigger to inform about a failure (different code than 200) - https://www.zabbix.com/integrations/slack and send a notification to you private message
  