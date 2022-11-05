/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dyhar
 */
public class BannerCharacter {
    private String charName;
    private int charRarity;
    private String charDescription;
    private String authorOpinion;
    private String charPortrait;
    private String charSplash;
    
    public BannerCharacter(String charName, int charRarity, String charDescription, String authorOpinion, String charPortrait,String charSplash){
        this.charName = charName;
        this.charRarity = charRarity; 
        this.charDescription = charDescription;
        this.authorOpinion = authorOpinion;
        this.charPortrait = charPortrait;
        this.charSplash = charSplash;
    }
    
    public String getName(){
        return charName;
    }
    
    public int getRarity(){
        return charRarity;
    }
    
    public String getDescription(){
        return charDescription;
    }
    
    public String getOpinion(){
        return authorOpinion;
    }
    
    public String getCharPortrait(){
        return charPortrait;
    }
    public String getCharSplash(){
        return charSplash;
    }
}
