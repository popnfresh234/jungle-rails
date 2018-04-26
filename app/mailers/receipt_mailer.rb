class ReceiptMailer < ApplicationMailer
    default from: 'no_reply@jungle.com'

    def receipt_email(order)
        @order = order
        #@url  = 'http://example.com/login'
        mail(to: @order.email, subject: @order.id)
    end
end
