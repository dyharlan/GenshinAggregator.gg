/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.io.*;
import java.util.ArrayList;
/**
 *
 * @author dyhar
 */



public class BannerModel {
    
    private ArrayList<BannerCharacter> bc;
    public BannerModel(String file) throws FileNotFoundException, IOException, IncompleteDataException{
        bc = addCharacter(file);
    }
    
    ArrayList<BannerCharacter> addCharacter(String file) throws FileNotFoundException, IOException, IncompleteDataException{
        ArrayList<BannerCharacter> temp = new ArrayList<>();
        
        BufferedReader br = new BufferedReader(new FileReader(file));
        String str;
        String charName = null;
        int charRarity = -1;
        String charDescription = null;
        String authorOpinion = null;
        String charPortrait = null;
        String charSplash = null;
        int charNumber = 0;
        while((str = br.readLine()) != null)
        {
            //A string var is added because for some reason startsWith() doesn't seem to work properly when directly invoked on the scanner.
            //Ignores any line that starts with an equals or space.
            if(str.startsWith(" ")){
                continue;
            }
            if(str.startsWith("Character Name:")){
                String[] tmpString = str.split(":");
                charName = tmpString[1].trim();
            }
            if(str.startsWith("Rarity:")){
                String[] tmpString = str.split(":");
                charRarity = Integer.parseInt(tmpString[1].trim());
            }
            if(str.startsWith("Description:")){
                String[] tmpString = str.split(":");
                charDescription = tmpString[1].trim();
            }
            if(str.startsWith("Opinion:")){
                String[] tmpString = str.split(":");
                authorOpinion = tmpString[1].trim();
            }
            if(str.startsWith("Character Portrait:")){
                String[] tmpString = str.split(":");
                charPortrait = tmpString[1].trim();
            }
            if(str.startsWith("Character Splash:")){
                String[] tmpString = str.split(":");
                charSplash = tmpString[1].trim();
            }
            if(str.startsWith("#")){
               temp.add(charNumber, new BannerCharacter(charName, charRarity, charDescription, authorOpinion,charPortrait,charSplash));
               charNumber++;
            }
        }
        br.close();
        if(temp.size() < 5){
            throw new IncompleteDataException();
        }
        return temp;
    }
    
    public BannerCharacter charInfo(int index){
        return bc.get(index);
    }
    
//    public String getName(int index){
//        return bc.get(index).getName();
//    }
//    
//    public int getRarity(int index){
//        return bc.get(index).getRarity();
//    }
//    
//    public String getDescription(int index){
//        return bc.get(index).getDescription();
//    }
//    
//    public String getOpinion(int index){
//        return bc.get(index).getDescription();
//    }
//    
//    public String getCharPortrait(int index){
//        return bc.get(index).getDescription();
//    }
//    public String getCharSplash(int index){
//        return bc.get(index).getDescription();
//    } 
}
