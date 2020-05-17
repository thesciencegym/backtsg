class Order < ApplicationRecord
  enum status: %i[pending succeeded]
  enum delivery_status: %i[not_required Scheduled Contacting_Merchant Picking_Up
                           Courier_Received At_Warehouse Agent_Out On_Route At_Customer
                           Delivered Cancelled Delivery_Failed Return_Scheduled	Package_Returned]

  belongs_to :user
  belongs_to :product
end
