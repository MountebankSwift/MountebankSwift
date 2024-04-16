# ``MountebankSwift/Mountebank``

## Topics

### Creating a Mountebank client
- ``init(host:port:)``

### Creating imposters
- ``postImposter(imposter:)``
- ``postImposter(imposter:completion:)``
- ``putImposters(imposters:)``
- ``putImposters(imposters:completion:)``

### Changing imposters
- ``postImposterStub(stub:index:port:)``
- ``postImposterStub(stub:index:port:completion:)``
- ``putImposterStub(stub:port:stubIndex:)``
- ``putImposterStub(stub:port:stubIndex:completion:)``
- ``putImposterStubs(stubs:port:)``
- ``putImposterStubs(stubs:port:completion:)``
- ``deleteStub(port:stubIndex:)``
- ``deleteStub(port:stubIndex:completion:)``
- ``deleteSavedProxyResponses(port:)``
- ``deleteSavedProxyResponses(port:completion:)``
- ``deleteSavedRequests(port:)``
- ``deleteSavedRequests(port:completion:)``

### Deleting imposters
- ``deleteAllImposters()``
- ``deleteAllImposters(completion:)``
- ``deleteImposter(port:replayable:removeProxies:)``
- ``deleteImposter(port:replayable:removeProxies:completion:)``

### Retrieve Imposter
- ``getAllImposters(replayable:removeProxies:)``
- ``getAllImposters(replayable:removeProxies:completion:)``
- ``getImposter(port:replayable:removeProxies:)``
- ``getImposter(port:replayable:removeProxies:completion:)``

### Introspection
- ``mountebankURL``
- ``testConnection()``
- ``testConnection(completion:)``
- ``makeImposterUrl(port:)``
- ``getConfig()``
- ``getConfig(completion:)``
- ``getLogs(parameters:)``
- ``getLogs(parameters:completion:)``
