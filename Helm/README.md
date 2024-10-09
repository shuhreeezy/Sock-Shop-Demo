# sock-shop

This chart deploys [SockShop](https://microservices-demo.github.io/) application. It was forked from [microservices-demo/microservices-demo](https://github.com/microservices-demo/microservices-demo/tree/master/deploy/kubernetes/helm-chart)
and got some improvements.

![Version: 0.2.7](https://img.shields.io/badge/Version-0.2.7-informational?style=flat-square) ![AppVersion: 0.3.5](https://img.shields.io/badge/AppVersion-0.3.5-informational?style=flat-square)
A Helm chart for Sock Shop

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| all.java.options | string | `"-Xms512m -Xmx512m -XX:PermSize=32m -XX:MaxPermSize=64m -XX:+UseG1GC -Djava.security.egd=file:/dev/urandom"` | The common JAVA_OPTS for all Java microservices. |
| all.securityCapabilitiesDisabled | bool | `false` | Disable securtyContext capabilities operations. |
| carts.affinity | object | `{}` | Affinity settings for carts pods. |
| carts.annotations | object | `{}` |  |
| carts.enabled | bool | `true` |  |
| carts.resources | object | `{"limits":{"cpu":"500m","memory":"1000Mi"},"requests":{"cpu":"500m","memory":"1000Mi"}}` | Resource allocation for `carts` pods. |
| carts.version | int | `1` | Custom label (version) value for `carts` pods. |
| cartsDB.annotations."monitor.kubernetes-v2.stackstate.io/pod-cpu-throttling" | string | `"{\"enabled\":false}"` |  |
| cartsDB.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | Resource allocation for `carts-db` pods. |
| catalogue.annotations | object | `{"vcs":"https://gitlab.com/stackvista/demo/microservices-demo/catalogue/-/commit/e9e5338599dbda30366b38d00794c34aaa4221a7"}` | Custom annotations for `catalogue` pods. |
| catalogue.demoScenarioSimulation.enabled | bool | `false` | Whether the k8s demo scenario should be enabled. |
| catalogue.demoScenarioSimulation.schedule | object | `{"failure":"0 * * * *","fix":"30 * * * *"}` | The cron schedule to trigger the k8s demo scenario. |
| catalogue.demoScenarioSimulation.schedule.failure | string | `"0 * * * *"` | The cron schedule to trigger the faulty k8s demo scenario. |
| catalogue.demoScenarioSimulation.schedule.fix | string | `"30 * * * *"` | The cron schedule to fix the faulty k8s demo scenario. |
| catalogue.enabled | bool | `true` |  |
| catalogue.image.repository | string | `"quay.io/stackstate/weaveworksdemo-catalogue"` | The container repository for `catalogue` images. |
| catalogue.image.tag | string | `"0.3.5"` | The container image tag. |
| catalogue.resources | object | `{"limits":{"cpu":"100m","memory":"200Mi"},"requests":{"cpu":"100m","memory":"200Mi"}}` | Resource allocation for `catalogue` pods. |
| catalogueDB.annotations."monitor.kubernetes-v2.stackstate.io/pod-cpu-throttling" | string | `"{\"enabled\":false}"` |  |
| catalogueDB.image.repository | string | `"quay.io/stackstate/weaveworksdemo-catalogue-db"` | The container repository for `catalogue-db` images. |
| catalogueDB.image.tag | string | `"0.3.1"` | The container image tag. |
| catalogueDB.resources | object | `{"limits":{"cpu":"1000m","memory":"500Mi"},"requests":{"cpu":"500m","memory":"250Mi"}}` | Resource allocation for `catalogue-db` pods. |
| frontend.annotations | object | `{}` |  |
| frontend.components.cartsHost | string | `"carts"` |  |
| frontend.components.catalogueHost | string | `"catalogue"` |  |
| frontend.components.ordersHost | string | `"orders"` |  |
| frontend.components.userHost | string | `"user"` |  |
| frontend.enabled | bool | `true` |  |
| frontend.image.repository | string | `"quay.io/stackstate/weaveworksdemo-front-end"` | The container repository for `frontend` images. |
| frontend.image.tag | string | `"0.3.13"` | The container image tag. |
| frontend.replicas | int | `1` | The number or replicas of `frontend` deployment. |
| frontend.resources | object | `{"limits":{"cpu":"300m","memory":"1000Mi"},"requests":{"cpu":"200m","memory":"1000Mi"}}` | Resource allocation for `frontend` pods. |
| global.annotations | object | `{}` |  |
| ingress.annotations | object | `{}` |  |
| ingress.replicas | int | `1` | The number or replicas of `ingress` deployment. |
| ingress.resources | object | `{"limits":{"cpu":"300m","memory":"1000Mi"},"requests":{"cpu":"200m","memory":"1000Mi"}}` | Resource allocation for `ingress` pods. |
| loadgen.annotations | object | `{}` |  |
| loadgen.enabled | bool | `false` |  |
| loadgen.image.repository | string | `"quay.io/stackstate/loadgen"` | The container repository for `loadgen` images. |
| loadgen.image.tag | string | `"master-f65782ce"` | The container image tag. |
| loadgen.replicas | int | `1` | The number or replicas of `loadgen` deployment. |
| loadgen.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | Resource allocation for `loadgen` pods. |
| nameOverride | string | `""` | A name to prepend the Helm resources, if not specified the name of the chart is used. |
| orders.annotations | object | `{}` |  |
| orders.backorderPriority | int | `0` | whatever it means. |
| orders.components.paymentHost | string | `"payment"` |  |
| orders.components.shippingHost | string | `"shipping"` |  |
| orders.enabled | bool | `true` |  |
| orders.image.repository | string | `"quay.io/stackstate/weaveworksdemo-orders"` | The container repository for `orders` images. |
| orders.image.tag | string | `"master"` | The container image tag. |
| orders.orderPriority | int | `0` | whatever it means. |
| orders.resources | object | `{"limits":{"cpu":"500m","memory":"1000Mi"},"requests":{"cpu":"500m","memory":"1000Mi"}}` | Resource allocation for `orders` pods. |
| orders.shippingPriority | int | `0` | whatever it means. |
| ordersDB.annotations | object | `{}` |  |
| ordersDB.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | Resource allocation for `orders-db` pods. |
| payment.annotations | object | `{}` |  |
| payment.enabled | bool | `true` |  |
| payment.ingress.annotations | object | `{}` |  |
| payment.ingress.enabled | bool | `false` | Whether to deploy Ingress resource for payment service |
| payment.ingress.hostname | string | `""` |  |
| payment.ingress.ingressClassName | string | `"ingress-nginx"` |  |
| payment.ingress.tls | bool | `false` |  |
| payment.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | Resource allocation for `payment` pods. |
| priority | int | `1000000000` | priority for the custom PriorityClass |
| queueMaster.annotations | object | `{}` |  |
| queueMaster.resources | object | `{"limits":{"cpu":"500m","memory":"1000Mi"},"requests":{"cpu":"500m","memory":"1000Mi"}}` | Resource allocation for `queue-master` pods. |
| rabbitmq.annotations | object | `{}` |  |
| rabbitmq.resources | object | `{"limits":{"cpu":"100m","memory":"200Mi"},"requests":{"cpu":"100m","memory":"200Mi"}}` | Resource allocation for `rabbitmq` pods. |
| scc.enabled | bool | `false` | Create `SecurityContextConstraints` resource to manage Openshift security constraints for Stackstate. |
| scc.extraServiceAccounts | list | `[]` | Extraccounts from the same namespace to add to SecurityContextConstraints users. |
| sessionDB.annotations | object | `{}` |  |
| sessionDB.limits.cpu | string | `"100m"` |  |
| sessionDB.limits.memory | string | `"100Mi"` |  |
| sessionDB.requests.cpu | string | `"100m"` |  |
| sessionDB.requests.memory | string | `"100Mi"` |  |
| shipping.annotations | object | `{}` |  |
| shipping.enabled | bool | `true` |  |
| shipping.ingress.annotations | object | `{}` |  |
| shipping.ingress.enabled | bool | `false` |  |
| shipping.ingress.hostname | string | `""` |  |
| shipping.ingress.ingressClassName | string | `"ingress-nginx"` |  |
| shipping.ingress.tls | bool | `false` |  |
| shipping.resources | object | `{"limits":{"cpu":"500m","memory":"1000Mi"},"requests":{"cpu":"500m","memory":"1000Mi"}}` | Resource allocation for `shipping` pods. |
| user.annotations | object | `{}` |  |
| user.enabled | bool | `true` |  |
| user.limits.cpu | string | `"300m"` |  |
| user.limits.memory | string | `"1000Mi"` |  |
| user.requests.cpu | string | `"100m"` |  |
| user.requests.memory | string | `"400Mi"` |  |
| userDB.annotations | object | `{}` |  |
| userDB.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | Resource allocation for `user-db` pods. |
