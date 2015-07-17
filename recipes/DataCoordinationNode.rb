log "\n=========== Start Data Coordination Node Config =============\n"

include_recipe 'mapr::DataNode'
package 'mapr-cldb'
