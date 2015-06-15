using UnityEngine;
using System.Collections;

public class rotater : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

		var temp = transform.rotation.eulerAngles + new Vector3(1f, 2f, 3f) ;
		transform.rotation = Quaternion.Euler (temp);
	}
}
