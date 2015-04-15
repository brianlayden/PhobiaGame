using UnityEngine;
using System.Collections;

public class BridgeFallScript : MonoBehaviour {

	public HingeJoint hingey;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter(Collider other)
	{
		Destroy (hingey);
		}
}
