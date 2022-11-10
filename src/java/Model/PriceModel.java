/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dyhar
 */
public class PriceModel{
        private String item;
        private Float itemPrice;
        private String ccType;
        public Float getItemPrice() {
            return itemPrice;
        }

        public String getCcType() {
            return ccType;
        }
        public String getItemName(){
            return item;
        }
        
         
    public PriceModel(String item, String ccType){
        switch(item){
            case "r1":
                itemPrice = 49f;
                this.item = "60 Genesis Crystals";
            break;
            case "r2":
                itemPrice = 249f;
                this.item = "300+30 Genesis Crystals";
            break;
            case "r3":
                itemPrice = 749f;
                this.item = "980+110 Genesis Crystals";
            break;
            case "r4":
                itemPrice = 1490f;
                this.item = "1980+260 Genesis Crystals";
            break;
            case "r5":
                itemPrice = 2490f;
                this.item = "3280+600 Genesis Crystals";
            break;
            case "r6":
                itemPrice = 4990f;
                this.item = "6480+1600 Genesis Crystals";
            break;
            case "r7":
                itemPrice = 249f;
                this.item = "Blessing of the Welkin Moon";
            break;
            default:
                itemPrice = null;
                item = null;
            break;
                
        }
        
        switch(ccType){
            case "visa":
                this.ccType = "Visa";
                break;
            case "masterCard":
                this.ccType = "MasterCard";
            default:
                this.ccType = null;
            break;
           
        }
    }
    
   
}
