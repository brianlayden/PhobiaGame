using UnityEngine;
using System.Collections;

public class activateBridgeFall : MonoBehaviour {
	public HingeJoint bridgeHinge;
	public Collider BridgeCollider;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	void OnTriggerEnter(Collider bridgeCollider)
	{
		Destroy (bridgeHinge);
		}
}
