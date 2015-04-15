using UnityEngine;
using System.Collections;

public class WindZone : MonoBehaviour {
	public GameObject character;
	// Use this for initialization
	void Start () {
		character.GetComponent<ConstantForce> ();
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
