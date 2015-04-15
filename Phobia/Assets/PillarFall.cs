using UnityEngine;
using System.Collections;

public class PillarFall : MonoBehaviour {

	private bool timerStart = false;
	public double timer = 0;

	public AudioSource audio;

	// Use this for initialization
	void Start () {
		timerStart = true;
	}
	
	// Update is called once per frame
	void Update () {
	if (timerStart == true) {
			timer+=(Time.deltaTime*15);
				}

		if (timer > 25) {
			audio.enabled=true;
				}
		if (timer >= 35) {
			this.rigidbody.useGravity=true;
				}
		if (timer >= 55) {
			audio.enabled=false;
				}
		if (timer >= 85) {
			Destroy (this);
				}
	}


}
