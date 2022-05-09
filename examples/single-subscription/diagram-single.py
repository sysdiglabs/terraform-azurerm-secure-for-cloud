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

with Diagram("Sysdig Secure for Cloud\n(Single Subscription)", graph_attr=diagram_attr, filename="diagram-single",
             show=True,
             direction="TB"):
    public_registries = Custom("Public Registries","../../resources/diag-registry-icon.png")

    with Cluster("Azure Tenant"):
        app = EnterpriseApplications("Enterprise App")

        with Cluster("Azure Account Subscription"):
            diagnosticSettings = AppConfiguration("Diagnostic Settings")
            with Cluster("Resource Group"):
              with Cluster("AzureContainerRegistry"):
                eventGrid = EventGridDomains("Event Grid \n(event subscription topic)")
                cregistry = ContainerRegistries("ACR Task \n(image scanning)")

              eventhubCC = EventHubs("Cloud Connector \nEvent Hub")
              eventhubCS = EventHubs("Cloud Scanning \nEvent Hub")
              diagnosticSettings >> eventhubCC
              with Cluster("Container Instance Group"):
                  cc = ContainerInstances("Cloud Connector \n Container Instance")

              lighthouse = Custom("Azure Lighthouse \n CSPM", "../../resources/diag-lighthouse.jpeg")


              cregistry << app

              eventhubCC >> cc
              eventhubCS >> cc
              cc >> app

              eventGrid << cregistry
              eventGrid >> eventhubCS


    with Cluster("Sysdig", graph_attr={"bgcolor": "lightblue"}):
        sds = Custom("Sysdig Secure", "../../resources/diag-sysdig-icon.png")
        bench = General("Cloud Bench")
        sds >> Edge(label="schedule on rand rand * * *") >> bench

    sds << Edge(style="dashed") << cc
    lighthouse <<  Edge(color=color_non_important) << bench
    cregistry >> Edge(style="dashed")  >> sds
    cregistry >> Edge(color=color_non_important) >> public_registries
