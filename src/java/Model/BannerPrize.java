/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dyhar
 */
public class BannerPrize {
    private String name;
    private int rarity;
    private String description;
    private String opinion;
    private String portrait;
    private String splashArt;
    
    public BannerPrize(String name, int rarity, String description, String opinion, String portrait,String splashArt){
        this.name = name;
        this.rarity = rarity; 
        this.description = description;
        this.opinion = opinion;
        this.portrait = portrait;
        this.splashArt = splashArt;
    }
    
    public String getName(){
        return name;
    }
    
    public int getRarity(){
        return rarity;
    }
    
    public String getDescription(){
        return description;
    }
    
    public String getOpinion(){
        return opinion;
    }
    
    public String getPortrait(){
        return portrait;
    }
    public String getSplashArt(){
        return splashArt;
    }
}
