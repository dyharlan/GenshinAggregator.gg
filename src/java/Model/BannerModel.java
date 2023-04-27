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


//creates a set of characters with loaaded information
public class BannerModel {
    private int charSize;
    private ArrayList<BannerPrize> bc;
    private ArrayList<BannerPrize> wb;
    
    public BannerModel(String charFile, int size) throws FileNotFoundException, IOException, IncompleteDataException{
        bc = addCharacter(charFile);
        this.charSize = size;
    }
    
    public BannerModel(String charFile, String wpnFile, int size) throws FileNotFoundException, IOException, IncompleteDataException{
        bc = addCharacter(charFile);
        wb = addWeapon(wpnFile);
        this.charSize = size;
    }
    
    ArrayList<BannerPrize> addCharacter(String file) throws FileNotFoundException, IOException, IncompleteDataException{
        ArrayList<BannerPrize> temp = new ArrayList<>();
        
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
               temp.add(charNumber, new BannerPrize(charName, charRarity, charDescription, authorOpinion,charPortrait,charSplash));
               charNumber++;
            }
        }
        br.close();
        if(temp.size() < charSize){
            throw new IncompleteDataException();
        }
        return temp;
    }
    
    public BannerPrize charInfo(int index){
        return bc.get(index);
    }
    
    ArrayList<BannerPrize> addWeapon(String file) throws FileNotFoundException, IOException, IncompleteDataException{
        ArrayList<BannerPrize> temp = new ArrayList<>();
        
        BufferedReader br = new BufferedReader(new FileReader(file));
        String str;
        String wpnName = null;
        int wpnRarity = -1;
        String wpnDescription = null;
        String authorOpinion = null;
        String wpnPortrait = null;
        String wpnSplash = null;
        int wpnNumber = 0;
        while((str = br.readLine()) != null)
        {
            //A string var is added because for some reason startsWith() doesn't seem to work properly when directly invoked on the scanner.
            //Ignores any line that starts with an equals or space.
            if(str.startsWith(" ")){
                continue;
            }
            if(str.startsWith("Weapon Name:")){
                String[] tmpString = str.split(":");
                wpnName = tmpString[1].trim();
            }
            if(str.startsWith("Rarity:")){
                String[] tmpString = str.split(":");
                wpnRarity = Integer.parseInt(tmpString[1].trim());
            }
            if(str.startsWith("Description:")){
                String[] tmpString = str.split(":");
                wpnDescription = tmpString[1].trim();
            }
            if(str.startsWith("Opinion:")){
                String[] tmpString = str.split(":");
                authorOpinion = tmpString[1].trim();
            }
            if(str.startsWith("Weapon Portrait:")){
                String[] tmpString = str.split(":");
                wpnPortrait = tmpString[1].trim();
            }
            if(str.startsWith("Weapon Splash:")){
                String[] tmpString = str.split(":");
                wpnSplash = tmpString[1].trim();
            }
            if(str.startsWith("#")){
               temp.add(wpnNumber, new BannerPrize(wpnName, wpnRarity, wpnDescription, authorOpinion,wpnPortrait,wpnSplash));
               wpnNumber++;
            }
        }
        br.close();
        if(temp.size() < 7){
            throw new IncompleteDataException();
        }
        return temp;
    }
    
    public BannerPrize wpnInfo(int index){
        return wb.get(index);
    }
}
