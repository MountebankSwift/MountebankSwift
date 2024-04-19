# ``MountebankSwift``

A swift client library for Mountebank.

## Overview

MountebankSwift is a client library for [Mountebank](https://www.mbtest.org/) - open source tool that
provides test doubles over the wire. It provides all the [api functionality](https://www.mbtest.org/docs/api/overview)
to interact with a running Mountebank instance.

![Mountebank logo holding a bottle with Swift's icon on it](MountebankSwift.jpg)

## Topics

### Connect to Mountebank
- ``Mountebank``
- ``Host``
- ``Config``

### Creating Imposters
- ``Imposter``

### Creating Stubs
- ``Stub``

### Creating Predicates
- ``Predicate``
- ``Request``
- ``PredicateParameters``
- ``JSONPath``
- ``XPath``

### Creating Responses
- ``Is``
- ``Inject``
- ``Fault``
- ``Proxy``

### Other symbols related to Responses
- ``StubResponse``
- ``ResponseParameters``
- ``Behavior``
- ``Body``

### Logs, Errors
- ``Logs``
- ``LogLevel``
- ``MountebankValidationError``
- ``MountebankErrors``

### Common
- ``HTTPMethod``
- ``JSON``

