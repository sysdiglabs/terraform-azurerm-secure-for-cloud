# diagrams as code vía https://diagrams.mingrammer.com

from diagrams.aws.general import General
from diagrams import Diagram, Cluster, Edge
from diagrams.azure.compute import ContainerInstances, ContainerRegistries, FunctionApps
from diagrams.azure.storage import StorageAccounts
from diagrams.azure.analytics import EventHubs
from diagrams.azure.integration import EventGridDomains, AppConfiguration
from diagrams.azure.identity import EnterpriseApplications
from diagrams.custom import Custom

diagram_attr = {
    "pad": "0.25"
}

role_attr = {
    "imagescale": "false",
    "height": "1.5",
    "width": "3",
    "fontsize": "9",
}

color_non_important="gray"

with Diagram("Sysdig Secure for Cloud\n(Tenant-Subscriptions)", graph_attr=diagram_attr, filename="diagram-tenant",
             show=True,
             direction="TB"):
    with Cluster("Azure Tenant"):
        app = EnterpriseApplications("Enterprise App")

        with Cluster("Azure Account Subscription 2..n", graph_attr={"bgcolor": "seashell2"}):
            diagnosticSettings = AppConfiguration("Diagnostic Settings")
            lighthouse1 = Custom("Azure Lighthouse \n CSPM", "../../resources/diag-lighthouse.jpeg")

            with Cluster("Resource Group"):
                eventhubCC1 = EventHubs("Cloud Connector \n Event Hub")
#                eventhubCS1 = EventHubs("Cloud Scanning \n Event Hub")
# not supported yet
#                with Cluster("AzureContainerRegistry"):
#                  eventGrid = EventGridDomains("Event Grid \n(event subscription topic)")
#                 cregistry = ContainerRegistries("ACR Task \n(image scanning)")

                diagnosticSettings >> eventhubCC1
#                eventGrid << cregistry
#                eventGrid >> eventhubCS1

        with Cluster("Azure Account Subscription 1 (with Sysdig workload)"):
            diagnosticSettings = AppConfiguration("Diagnostic Settings")
            lighthouse2 = Custom("Azure Lighthouse \n CSPM", "../../resources/diag-lighthouse.jpeg")

            with Cluster("Resource Group"):
                eventhubCC = EventHubs("Cloud Connector \n Event Hub")
                eventhubCS = EventHubs("Cloud Scanning \n Event Hub")
                diagnosticSettings >> eventhubCC


                with Cluster("AzureContainerRegistry"):
                  eventGrid = EventGridDomains("Event Grid \n(event subscription topic)")
                  cregistry = ContainerRegistries("ACR Task \n(image scanning)")

                with Cluster("Container Instance Group"):
                    cc = ContainerInstances("Cloud Connector \n Container Instance")

                ccConfig = StorageAccounts("Cloud Connector \n config")

                ccConfig >> Edge(style="dotted") >> cc
                cregistry << app

                eventhubCC >> cc
                eventhubCS >> cc
                cc >> app

                eventGrid << cregistry
                eventGrid >> eventhubCS

                eventhubCC1 >> cc
#                eventhubCS1 >> cc

    with Cluster("Sysdig", graph_attr={"bgcolor": "lightblue"}):
        sds = Custom("Sysdig Secure", "../../resources/diag-sysdig-icon.png")
        bench = General("Cloud Bench")
        sds >> Edge(label="schedule on rand rand * * *") >> bench

    sds << Edge(style="dashed") << cc
    lighthouse1 <<  Edge(color=color_non_important) << bench
    lighthouse2 <<  Edge(color=color_non_important) << bench
