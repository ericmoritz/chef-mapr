log "\n=========== Start Worker Node Config =============\n"

include_recipe 'mapr::DataNode'
package 'mapr-nodemanager'
