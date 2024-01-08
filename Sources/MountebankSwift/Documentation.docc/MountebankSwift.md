# ``MountebankSwift``

A swift client library for Mountebank.

## Overview

MountebankSwift is a client library for [Mountebank](https://www.mbtest.org/) - open source tool that
provides test doubles over the wire. It provides all the [api functionality](https://www.mbtest.org/docs/api/overview)
to interact with a running Mountebank instance.

## Topics

### Connect to Mountebank
- ``Mountebank``

### Creating Imposters
- ``Imposter``
- ``Imposters``
- ``NetworkProtocol``

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

- ``StubResponse``
- ``ResponseParameters``
- ``Behavior``
- ``Body``

### Config, Logs, Errors
- ``Config``
- ``Logs``
- ``LogLevel``
- ``MountebankValidationError``
- ``MountebankErrors``

### Common
- ``HTTPMethod``
- ``JSON``
- ``Host``
