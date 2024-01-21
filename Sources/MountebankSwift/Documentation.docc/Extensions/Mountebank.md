# ``MountebankSwift/Mountebank``

## Topics

### Creating a Mountebank client
- ``init(host:port:)``

### Creating imposters
- ``postImposter(imposter:)``
- ``putImposters(imposters:)``

### Changing imposters
- ``postImposterStub(stub:index:port:)``
- ``putImposterStub(stub:port:stubIndex:)``
- ``putImposterStubs(stubs:port:)``
- ``deleteStub(port:stubIndex:)``
- ``deleteSavedProxyResponses(port:)``
- ``deleteSavedRequests(port:)``

### Deleting imposters
- ``deleteAllImposters()``
- ``deleteImposter(port:)``

### Retrieve Imposter
- ``getAllImposters()``
- ``getImposter(port:)``

### Introspection
- ``mountebankURL``
- ``testConnection()``
- ``makeImposterUrl(port:)``
- ``getConfig()``
- ``getLogs(startIndex:endIndex:)``
