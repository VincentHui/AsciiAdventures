using UnityEngine;
using System.Collections;

public class renderImage : MonoBehaviour {
	public Material mat1;
	// Called by the camera to apply the image effect
	void OnRenderImage (RenderTexture source, RenderTexture destination){
		
		//mat is the material containing your shader
		Graphics.Blit(source,destination,mat1);
	}
}
